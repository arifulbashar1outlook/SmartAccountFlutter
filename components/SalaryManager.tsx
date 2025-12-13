import React, { useState, useEffect } from 'react';
import { Eye, EyeOff, Plus, Lock, ArrowDownCircle, Wallet } from 'lucide-react';
import { Transaction, AccountType, Category } from '../types';

interface SalaryManagerProps {
  onAddTransaction: (t: Omit<Transaction, 'id'>) => void;
}

const SalaryManager: React.FC<SalaryManagerProps> = ({ onAddTransaction }) => {
  const [activeTab, setActiveTab] = useState<'salary' | 'received'>('salary');
  
  // Salary State
  const [salary, setSalary] = useState<string>('');
  const [isVisible, setIsVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [salaryDestination, setSalaryDestination] = useState<AccountType>('salary');

  // Received Money State
  const [receivedAmount, setReceivedAmount] = useState('');
  const [receivedDesc, setReceivedDesc] = useState('');
  const [receivedDestination, setReceivedDestination] = useState<AccountType>('cash');

  useEffect(() => {
    const saved = localStorage.getItem('smartspend_salary_pref');
    if (saved) setSalary(saved);
  }, []);

  const handleSave = () => {
    localStorage.setItem('smartspend_salary_pref', salary);
    setIsEditing(false);
    setIsVisible(false);
  };

  const handleAddToMonth = () => {
    if (!salary) return;
    onAddTransaction({
      amount: parseFloat(salary),
      type: 'income',
      category: Category.SALARY,
      description: 'Monthly Salary',
      date: new Date().toISOString().split('T')[0],
      accountId: salaryDestination
    });
  };

  const handleAddReceivedMoney = () => {
    if (!receivedAmount) return;
    onAddTransaction({
      amount: parseFloat(receivedAmount),
      type: 'income',
      category: Category.OTHER,
      description: receivedDesc || 'Received Money',
      date: new Date().toISOString().split('T')[0],
      accountId: receivedDestination
    });
    setReceivedAmount('');
    setReceivedDesc('');
  };

  return (
    <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-100 dark:border-gray-700 overflow-hidden mb-6 transition-colors duration-200">
      {/* Tabs */}
      <div className="flex border-b border-gray-100 dark:border-gray-700">
        <button
          onClick={() => setActiveTab('salary')}
          className={`flex-1 py-3 text-sm font-medium flex items-center justify-center gap-2 transition-colors ${
            activeTab === 'salary' 
              ? 'bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 border-b-2 border-indigo-600 dark:border-indigo-400' 
              : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700/50'
          }`}
        >
          <Lock className="w-4 h-4" />
          Salary
        </button>
        <button
          onClick={() => setActiveTab('received')}
          className={`flex-1 py-3 text-sm font-medium flex items-center justify-center gap-2 transition-colors ${
            activeTab === 'received' 
              ? 'bg-emerald-50 dark:bg-emerald-900/20 text-emerald-600 dark:text-emerald-400 border-b-2 border-emerald-600 dark:border-emerald-400' 
              : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-700/50'
          }`}
        >
          <ArrowDownCircle className="w-4 h-4" />
          Receive Money
        </button>
      </div>

      <div className="p-6">
        {activeTab === 'salary' ? (
          <div className="space-y-4">
            <div className="flex items-center justify-between mb-2">
               <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300">Monthly Salary Config</h4>
               <button
                onClick={() => setIsVisible(!isVisible)}
                className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300 transition-colors"
              >
                {isVisible ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            </div>
            
            <div className="relative">
              {isEditing ? (
                <div className="flex gap-2">
                  <input
                    type="number"
                    value={salary}
                    onChange={(e) => setSalary(e.target.value)}
                    placeholder="Enter salary"
                    className="flex-1 px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  />
                  <button
                    onClick={handleSave}
                    className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 font-medium"
                  >
                    Save
                  </button>
                </div>
              ) : (
                <div className="flex items-center justify-between bg-gray-50 dark:bg-gray-700/50 p-3 rounded-lg border border-gray-200 dark:border-gray-600">
                  <span className="text-xl font-bold text-gray-800 dark:text-white font-mono">
                    {isVisible ? `Tk ${parseFloat(salary || '0').toLocaleString()}` : '****'}
                  </span>
                  <button
                    onClick={() => setIsEditing(true)}
                    className="text-sm text-indigo-600 dark:text-indigo-400 font-medium hover:underline"
                  >
                    Edit
                  </button>
                </div>
              )}
            </div>

            <div className="pt-2">
               <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Deposit To</label>
               <select
                  value={salaryDestination}
                  onChange={(e) => setSalaryDestination(e.target.value as AccountType)}
                  className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none bg-white dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                >
                  <option value="salary">Salary Account 🏦</option>
                  <option value="savings">Savings Account 🐷</option>
                  <option value="cash">Cash 💵</option>
                </select>
            </div>

            <button
              onClick={handleAddToMonth}
              disabled={!salary || isEditing}
              className="w-full flex items-center justify-center gap-2 bg-indigo-600 text-white py-2.5 rounded-lg hover:bg-indigo-700 transition-colors font-medium disabled:opacity-50 disabled:cursor-not-allowed shadow-sm active:scale-[0.98] transform"
            >
              <Plus className="w-4 h-4" />
              Add Salary
            </button>
          </div>
        ) : (
          <div className="space-y-4">
             <div>
               <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Amount</label>
               <div className="relative">
                  <span className="absolute left-3 top-2.5 text-gray-500 dark:text-gray-400 font-bold text-xs pt-0.5">Tk</span>
                  <input
                    type="number"
                    value={receivedAmount}
                    onChange={(e) => setReceivedAmount(e.target.value)}
                    placeholder="0.00"
                    className="w-full pl-9 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  />
               </div>
             </div>

             <div className="grid grid-cols-2 gap-3">
               <div className="col-span-2">
                 <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Description (Optional)</label>
                 <input
                    type="text"
                    value={receivedDesc}
                    onChange={(e) => setReceivedDesc(e.target.value)}
                    placeholder="e.g. Gift, Bonus"
                    className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                  />
               </div>
               <div className="col-span-2">
                 <label className="block text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">Deposit To</label>
                 <select
                    value={receivedDestination}
                    onChange={(e) => setReceivedDestination(e.target.value as AccountType)}
                    className="w-full px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg focus:ring-2 focus:ring-emerald-500 outline-none bg-white dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                  >
                    <option value="cash">Cash 💵</option>
                    <option value="salary">Salary Account 🏦</option>
                    <option value="savings">Savings Account 🐷</option>
                  </select>
               </div>
             </div>

             <button
              onClick={handleAddReceivedMoney}
              disabled={!receivedAmount}
              className="w-full flex items-center justify-center gap-2 bg-emerald-600 text-white py-2.5 rounded-lg hover:bg-emerald-700 transition-colors font-medium disabled:opacity-50 disabled:cursor-not-allowed shadow-sm active:scale-[0.98] transform"
            >
              <Wallet className="w-4 h-4" />
              Receive Money
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default SalaryManager;