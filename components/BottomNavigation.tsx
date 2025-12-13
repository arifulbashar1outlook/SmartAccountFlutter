import React from 'react';
import { PlusCircle, Calendar, BarChart3, ShoppingBag, FileText } from 'lucide-react';

interface BottomNavigationProps {
  activeTab: 'input' | 'bazar' | 'report' | 'month' | 'year';
  onTabChange: (tab: 'input' | 'bazar' | 'report' | 'month' | 'year') => void;
}

const BottomNavigation: React.FC<BottomNavigationProps> = ({ activeTab, onTabChange }) => {
  return (
    <div className="fixed bottom-0 left-0 right-0 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700 px-2 py-3 pb-safe z-50 transition-colors duration-200">
      <div className="max-w-md mx-auto flex justify-between items-center px-2">
        <button
          onClick={() => onTabChange('input')}
          className={`flex flex-col items-center gap-1 transition-colors min-w-[3rem] ${
            activeTab === 'input' ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300'
          }`}
        >
          <PlusCircle className={`w-6 h-6 ${activeTab === 'input' ? 'fill-current text-indigo-600 dark:text-indigo-400' : ''}`} />
          <span className="text-[10px] font-medium">Input</span>
        </button>

        <button
          onClick={() => onTabChange('bazar')}
          className={`flex flex-col items-center gap-1 transition-colors min-w-[3rem] ${
            activeTab === 'bazar' ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300'
          }`}
        >
          <ShoppingBag className="w-6 h-6" />
          <span className="text-[10px] font-medium">Bazar</span>
        </button>

        <button
          onClick={() => onTabChange('report')}
          className={`flex flex-col items-center gap-1 transition-colors min-w-[3rem] ${
            activeTab === 'report' ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300'
          }`}
        >
          <FileText className="w-6 h-6" />
          <span className="text-[10px] font-medium">Report</span>
        </button>
        
        <button
          onClick={() => onTabChange('month')}
          className={`flex flex-col items-center gap-1 transition-colors min-w-[3rem] ${
            activeTab === 'month' ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300'
          }`}
        >
          <Calendar className="w-6 h-6" />
          <span className="text-[10px] font-medium">Monthly</span>
        </button>
        
        <button
          onClick={() => onTabChange('year')}
          className={`flex flex-col items-center gap-1 transition-colors min-w-[3rem] ${
            activeTab === 'year' ? 'text-indigo-600 dark:text-indigo-400' : 'text-gray-400 dark:text-gray-500 hover:text-gray-600 dark:hover:text-gray-300'
          }`}
        >
          <BarChart3 className="w-6 h-6" />
          <span className="text-[10px] font-medium">Yearly</span>
        </button>
      </div>
    </div>
  );
};

export default BottomNavigation;